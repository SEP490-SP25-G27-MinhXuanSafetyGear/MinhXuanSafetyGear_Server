using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;

namespace BusinessLogicLayer.Services.Interface;

public interface IUserService
{
    Task<EmployeeRequest?> EmployeeLoginByEmailAndPasswordAsync(FormLogin formLogin);
    Task<EmployeeRequest?> CreateNewEmployeeAsync(NewEmployee newEmployee);
    Task<List<EmployeeRequest>?> GetEmployeeByPageAsync(int page, int pageSize);
    Task<EmployeeRequest?> GetEmployeeByEmailAsync(string email);
    Task<EmployeeRequest?> GetEmployeeByIdAsync(int employeeId);
    Task<EmployeeRequest?> UpdateEmployeeAsync(UpdateEmployee updateEmployee);
    
    Task<CustomerRequest?> CreateNewCustomerAsync(NewCustomer newCustomer);
    Task<List<CustomerRequest>?> GetCustomerByPageAsync(int page, int pageSize);
    Task<CustomerRequest?> GetCustomerByEmailAsync(string email);
    Task<CustomerRequest?> UpdateCustomerAsync(UpdateCustomer updateCustomer);
}