using System.Collections.Generic;
using System.Threading.Tasks;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;

namespace BusinessLogicLayer.Services.Interface;

public interface IUserService
{
    //Employee
    /// <summary>
    /// Login by email and password
    /// </summary>
    /// <param name="formLogin"></param>
    /// <returns></returns>
    Task<EmployeeResponse?> EmployeeLoginByEmailAndPasswordAsync(FormLogin formLogin);
    Task<EmployeeResponse?> CreateNewEmployeeAsync(NewEmployee newEmployee);
    Task<List<EmployeeResponse>?> GetEmployeeByPageAsync(int page, int pageSize);
    Task<EmployeeResponse?> GetEmployeeByEmailAsync(string email);
    Task<EmployeeResponse?> GetEmployeeByIdAsync(int employeeId);
    Task<EmployeeResponse?> UpdateEmployeeAsync(UpdateEmployee updateEmployee);
    
    //Customer
    /// <summary>
    /// Create new customer and send email verification code 
    /// </summary>
    /// <param name="newCustomer"></param>
    /// <returns></returns>
    Task<CustomerResponse?> CreateNewCustomerAsync(NewCustomer newCustomer);
    Task<List<CustomerResponse>?> GetCustomerByPageAsync(int page, int pageSize);
    Task<CustomerResponse?> GetCustomerByEmailAsync(string email);
    Task<CustomerResponse?> UpdateCustomerAsync(UpdateCustomer updateCustomer);
    Task<bool> SendVerificationCodeBackAsync(string email, string typeAccount);
}