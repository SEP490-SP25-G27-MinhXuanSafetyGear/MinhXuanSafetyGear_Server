using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository;
using DataAccessObject.Repository.Interface;
using BCrypt.Net;
using BusinessLogicLayer.Models;
using Microsoft.Extensions.Configuration; // Thư viện để mã hóa mật khẩu
using Microsoft.Extensions.Logging; // Thư viện log

namespace BusinessLogicLayer.Services;

public class UserService : IUserService
{
    private readonly IUserRepo _userRepo;
    private readonly IMailService _mailService;
    private readonly IMapper _mapper;
    private readonly ILogger<UserService> _logger;
    // Inject ILogger vào constructor
    public UserService(MinhXuanDatabaseContext context, IMapper mapper, ILogger<UserService> logger,IMailService mailService )
    {
        _userRepo = new UserRepo(context);
        _mapper = mapper;
        _logger = logger;
        _mailService = mailService;
    }

    public async Task<EmployeeResponse?> EmployeeLoginByEmailAndPasswordAsync(FormLogin formLogin)
    {
        _logger.LogInformation("Starting login process for email: {Email}", formLogin.Email);

        var email = formLogin.Email;
        var password = formLogin.Password;

        try
        {
            var employee = await _userRepo.GetEmployeeByEmailAsync(email);
            if (employee == null)
            {
                _logger.LogWarning("Login failed for email {Email}: Employee not found", email);
                return null;
            }

            if (employee.Status != "Active")
            {
                return null;
            }
            if (BCrypt.Net.BCrypt.Verify(password, employee.PasswordHash))
            {
                _logger.LogInformation("Login successful for email {Email}", email);
                var empRequest = _mapper.Map<EmployeeResponse>(employee);
                return empRequest;
            }

            _logger.LogWarning("Login failed for email {Email}: Incorrect password", email);
            return null;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred during login process for email {Email}", email);
            throw;
        }
    }

    public async Task<EmployeeResponse?> CreateNewEmployeeAsync(NewEmployee newEmployee)
    {
        _logger.LogInformation("Starting employee creation for email: {Email}", newEmployee.Email);
        try
        {
            var employee = _mapper.Map<Employee>(newEmployee);
            employee.PasswordHash = BCrypt.Net.BCrypt.HashPassword(newEmployee.Password);
            var result = await _userRepo.CreateEmployeeAsync(employee);
            if (result == null)
            {
                _logger.LogWarning("Failed to create employee for email {Email}", newEmployee.Email);
                return null;
            }
            _logger.LogInformation("Employee created successfully for email {Email}", newEmployee.Email);
            var empRequest = _mapper.Map<EmployeeResponse>(result);
            return empRequest;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred during employee creation for email {Email}", newEmployee.Email);
            throw;
        }
    }

    public async Task<Page<EmployeeResponse>?> GetEmployeeByPageAsync(int page, int pageSize)
    {
        try
        {
            var emps = await _userRepo.GetEmployeesPageAsync(page, pageSize);
            var totalEmp = await _userRepo.CountEmployees();
            var empRequests = _mapper.Map<List<EmployeeResponse>>(emps);
            var pageResult = new Page<EmployeeResponse>(empRequests, page, pageSize, totalEmp);
            _logger.LogInformation("Get employee by page successfully");
            return pageResult;
        }catch(Exception ex)
        {
            _logger.LogError(ex, "An error occurred during get employee by page");
            throw new Exception("An error occurred during get employee by page");
        }
    }

    public async Task<EmployeeResponse?> GetEmployeeByEmailAsync(string email)
    {
        var emp = await _userRepo.GetEmployeeByEmailAsync(email);
        var empRequest = _mapper.Map<EmployeeResponse>(emp);
        return empRequest;
    }

    public async Task<EmployeeResponse?> GetEmployeeByIdAsync(int employeeId)
    {
        var emp = await _userRepo.GetEmployeeByIdAsync(employeeId);
        var empRequest = _mapper.Map<EmployeeResponse>(emp);
        return empRequest;
    }

    public async Task<EmployeeResponse?> UpdateEmployeeAsync(UpdateEmployee updateEmployee)
    {
        var existingEmployee = await _userRepo.GetEmployeeByIdAsync(updateEmployee.EmployeeId);
        _mapper.Map(updateEmployee, existingEmployee);
        var updatedEmployee = await _userRepo.UpdateEmployeeAsync(existingEmployee);
        var employeeResponse = _mapper.Map<EmployeeResponse>(updatedEmployee);
        return employeeResponse;
    }
    


    public async Task<CustomerResponse?> CreateNewCustomerAsync(NewCustomer newCustomer)
    {
        var customer = _mapper.Map<Customer>(newCustomer);
        customer.PasswordHash = BCrypt.Net.BCrypt.HashPassword(newCustomer.Password);
        var result = await _userRepo.CreateCustomerAsync(customer);
        var accountVerification = await _userRepo.GetAccountVerificationByIdAndTypeAccountAsync(customer.CustomerId);
        if (accountVerification != null)
        {
            var resultMail =
                await _mailService.SendVerificationEmailAsync(customer.Email, accountVerification.VerificationCode);
        }
        var customerRequest = _mapper.Map<CustomerResponse>(result);
        return customerRequest;
    }

    public async Task<CustomerResponse?> CustomerLoginByEmailAndPasswordAsync(FormLogin formLogin)
    {
        _logger.LogInformation("Starting login process for email: {Email}", formLogin.Email);

        var email = formLogin.Email;
        var password = formLogin.Password;

        try
        {
            var customer = await _userRepo.GetCustomerByEmailAsync(email);
            if (customer == null)
            {
                _logger.LogWarning("Login failed for email {Email}: Customer not found", email);
                return null;
            }

            if (customer.IsEmailVerified == false)
            {
                throw new Exception("Email is not verified");
            }
            if (BCrypt.Net.BCrypt.Verify(password, customer.PasswordHash))
            {
                _logger.LogInformation("Login successful for email {Email}", email);
                var cusResponst = _mapper.Map<CustomerResponse>(customer);
                return cusResponst;
            }

            _logger.LogWarning("Login failed for email {Email}: Incorrect password", email);
            return null;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred during login process for email {Email}", email);
            throw;
        }
    }

    public async Task<Page<CustomerResponse>?> GetCustomerByPageAsync(int page, int pageSize)
    {
        var customers = await _userRepo.GetCustomersPageAsync(page, pageSize);
        var totalCustomer = await _userRepo.CountCustomers();
        var customerRequests = _mapper.Map<List<CustomerResponse>>(customers);
        var pageResult = new Page<CustomerResponse>(customerRequests, page, pageSize, totalCustomer);
        return pageResult;
    }

    public async Task<CustomerResponse?> GetCustomerByEmailAsync(string email)
    {
        var customer = await _userRepo.GetCustomerByEmailAsync(email);
        var customerRequest = _mapper.Map<CustomerResponse>(customer);
        return customerRequest;
    }

    public async Task<CustomerResponse?> UpdateCustomerAsync(UpdateCustomer updateCustomer)
    {
        var customer = _mapper.Map<Customer>(updateCustomer);
        var result = await _userRepo.UpdateCustomerAsync(customer);
        var customerRequest = _mapper.Map<CustomerResponse>(result);
        return customerRequest;
    }


    public async Task<bool> SendVerificationCodeBackAsync(string email)
    {
        var customer = await _userRepo.GetCustomerByEmailAsync(email);
        if (customer == null)return false;
        var accountVerication = await _userRepo.CreateNewVefificationCodeAsync(customer.CustomerId);
        var sendMailresult = await 
            _mailService.SendVerificationEmailAsync(customer.Email, accountVerication.VerificationCode);
        return sendMailresult;
    }

    public async Task<CustomerResponse?> ConfirmEmailCustomerAsync(string email, string code)
    {
        try
        {
            var customer = await _userRepo.GetCustomerByEmailAsync(email);
            if (customer == null) return null;

            var accountVerification = await _userRepo.GetAccountVerificationByIdAndTypeAccountAsync(customer.CustomerId);
            if (accountVerification == null) return null;

            // Kiểm tra mã xác thực có đúng và có hết hạn chưa
            if (accountVerification.VerificationCode != code)
                return null;

            // Xác thực thành công, cập nhật trạng thái tài khoản
            var result = await _userRepo.ConfirmEmailCustomerSuccessAsync(customer.CustomerId);
            customer.IsEmailVerified = true;
            var customerRequest= await _userRepo.UpdateCustomerAsync(customer);
            return _mapper.Map<CustomerResponse>(customerRequest);   
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred during email confirmation");
            throw new Exception("An error occurred during email confirmation", ex);
        }
    }

}
