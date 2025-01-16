using BusinessObject.Entities;
using DataAccessObject.Dao;
using DataAccessObject.Repository.Interface;

namespace DataAccessObject.Repository;

public class UserRepo : IUserRepo
{
    private readonly CustomerDao _customerDao;
    private readonly EmployeeDao _employeeDao;
    public UserRepo(MinhXuanDatabaseContext context)
    {
        _customerDao = new CustomerDao(context);
        _employeeDao = new EmployeeDao(context);
    }
    public async Task<Customer?> GetCustomerByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<Customer?> GetCustomerByEmailAsync(string email)
    {
        throw new NotImplementedException();
    }

    public async Task<Customer?> GetCustomerByPhoneAsync(string phone)
    {
        throw new NotImplementedException();
    }

    public async Task<Customer?> CreateCustomerAsync(Customer customer)
    {
        throw new NotImplementedException();
    }

    public async Task<Customer?> UpdateCustomerAsync(Customer customer)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Customer>?> GetCustomersPageAsync(int page, int pageSize)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Customer>?> GetAllCustomersAsync()
    {
        throw new NotImplementedException();
    }

    public async Task<Employee?> GetEmployeeByIdAsync(int id)
    {
        throw new NotImplementedException();
    }

    public async Task<Employee?> GetEmployeeByEmailAsync(string email)
    {
        return await _employeeDao.GetEmployeeByEmailAsync(email);
    }

    public async Task<Employee?> GetEmployeeByPhoneAsync(string phone)
    {
        throw new NotImplementedException();
    }

    public async Task<Employee?> CreateEmployeeAsync(Employee employee)
    {
        var employees = await _employeeDao.GetAllAsync();
        if (employees.Any(e => e.Email == employee.Email))
        {
            throw new ArgumentException("Email already exists");
        }
        await _employeeDao.CreateAsync(employee);
        return employee;
    }

    public async Task<Employee?> UpdateEmployeeAsync(Employee employee)
    {
        throw new NotImplementedException();
    }

    public async Task<List<Employee>?> GetEmployeesPageAsync(int page, int pageSize)
    {
        return await _employeeDao.GetPageAsync(page, pageSize);
    }

    public async Task<List<Employee>?> GetAllEmployeesAsync()
    {
        throw new NotImplementedException();
    }
}