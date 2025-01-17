using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository;
using DataAccessObject.Repository.Interface;
using BCrypt.Net; // Thư viện để mã hóa mật khẩu
using Microsoft.Extensions.Logging; // Thư viện log

namespace BusinessLogicLayer.Services;

public class UserService : IUserService
{
    private readonly IUserRepo _userRepo;
    private readonly IMapper _mapper;
    private readonly ILogger<UserService> _logger;

    // Inject ILogger vào constructor
    public UserService(MinhXuanDatabaseContext context, IMapper mapper, ILogger<UserService> logger)
    {
        _userRepo = new UserRepo(context);
        _mapper = mapper;
        _logger = logger;
    }

    public async Task<EmployeeRequest?> EmployeeLoginByEmailAndPasswordAsync(FormLogin formLogin)
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

            if (BCrypt.Net.BCrypt.Verify(password, employee.PasswordHash))
            {
                _logger.LogInformation("Login successful for email {Email}", email);
                var empRequest = _mapper.Map<EmployeeRequest>(employee);
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

    public async Task<EmployeeRequest?> CreateNewEmployeeAsync(NewEmployee newEmployee)
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
            var empRequest = _mapper.Map<EmployeeRequest>(result);
            return empRequest;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred during employee creation for email {Email}", newEmployee.Email);
            throw;
        }
    }

    public async Task<List<EmployeeRequest>?> GetEmployeeByPageAsync(int page, int pageSize)
    {
        try
        {
            var emps = await _userRepo.GetEmployeesPageAsync(page, pageSize);
            var empRequests = _mapper.Map<List<EmployeeRequest>>(emps);
            _logger.LogInformation("Get employee by page successfully");
            return empRequests;
        }catch(Exception ex)
        {
            _logger.LogError(ex, "An error occurred during get employee by page");
            throw new Exception("An error occurred during get employee by page");
        }
    }

    public async Task<EmployeeRequest?> GetEmployeeByEmailAsync(string email)
    {
        var emp = await _userRepo.GetEmployeeByEmailAsync(email);
        var empRequest = _mapper.Map<EmployeeRequest>(emp);
        return empRequest;
    }

    public async Task<EmployeeRequest?> GetEmployeeByIdAsync(int employeeId)
    {
        var emp = await _userRepo.GetEmployeeByIdAsync(employeeId);
        var empRequest = _mapper.Map<EmployeeRequest>(emp);
        return empRequest;
    }

    public async Task<EmployeeRequest?> UpdateEmployeeAsync(UpdateEmployee updateEmployee)
    {
        var emp = _mapper.Map<Employee>(updateEmployee);
        var result = await _userRepo.UpdateEmployeeAsync(emp);
        var empRequest = _mapper.Map<EmployeeRequest>(result);
        return empRequest;
    }

    public async Task<CustomerRequest?> CreateNewCustomerAsync(NewCustomer newCustomer)
    {
        var customer = _mapper.Map<Customer>(newCustomer);
        var result = await _userRepo.CreateCustomerAsync(customer);
        var customerRequest = _mapper.Map<CustomerRequest>(result);
        return customerRequest;
    }

    public async Task<List<CustomerRequest>?> GetCustomerByPageAsync(int page, int pageSize)
    {
        var customers = await _userRepo.GetCustomersPageAsync(page, pageSize);
        var customerRequests = _mapper.Map<List<CustomerRequest>>(customers);
        return customerRequests;
    }

    public async Task<CustomerRequest?> GetCustomerByEmailAsync(string email)
    {
        var customer = await _userRepo.GetCustomerByEmailAsync(email);
        var customerRequest = _mapper.Map<CustomerRequest>(customer);
        return customerRequest;
    }

    public async Task<CustomerRequest?> UpdateCustomerAsync(UpdateCustomer updateCustomer)
    {
        var customer = _mapper.Map<Customer>(updateCustomer);
        var result = await _userRepo.UpdateCustomerAsync(customer);
        var customerRequest = _mapper.Map<CustomerRequest>(result);
        return customerRequest;
    }
}
