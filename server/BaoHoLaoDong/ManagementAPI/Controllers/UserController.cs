using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class UserController : ControllerBase
{
    private readonly IUserService _userService;
    public UserController(IUserService userService )
    {
        _userService = userService;
    }
    /// <summary>
    /// only admin can create new employee
    /// </summary>
    /// <param name="newEmployee"></param>
    /// <returns></returns>
    [HttpPost("create-employee")]
    public async Task<IActionResult> CreateNewEmployee ([FromBody] NewEmployee newEmployee)
    {
        try
        {
            var employee = await _userService.CreateNewEmployeeAsync(newEmployee);
            return Ok(employee);
        }catch(Exception e)
        {
            return BadRequest(e.Message);
        }
    }
    
    /// <summary>
    /// only admin can update employee
    /// </summary>
    /// <param name="updateEmployee"></param>
    /// <returns>Employee</returns>
    [HttpPut("update-employee")]
    public async Task<IActionResult> UpdateEmployee([FromBody] UpdateEmployee updateEmployee)
    {
        try
        {
            var employee = await _userService.UpdateEmployeeAsync(updateEmployee);
            return Ok(employee);
        }catch(Exception e)
        {
            return BadRequest(e.Message);
        }
    }
    
    /// <summary>
    /// admin and manager can get all employee
    /// </summary>
    /// <param name="page"></param>
    /// <param name="pageSize"></param>
    /// <returns></returns>
    [HttpGet("get-employee/page-{page}/pagesize-{pageSize}")]
    public async Task<IActionResult> GetEmployeeByPage([FromRoute] int page =1, [FromRoute] int pageSize =20)
    {
        try
        {
            var employees = await _userService.GetEmployeeByPageAsync(page, pageSize);
            return Ok(employees);
        }catch(Exception e)
        {
            return BadRequest(e.Message);
        }
    }
   
    /// <summary>
    /// admin and manager can get employee by id
    /// </summary>
    /// <param name="employeeId"></param>
    /// <returns>customer</returns>
    [HttpGet("get-employee-by-id/{employeeId}")]
    public async Task<IActionResult> GetEmployeeById([FromRoute] int employeeId)
    {
        try
        {
            var employee = await _userService.GetEmployeeByIdAsync(employeeId);
            return Ok(employee);
        }catch(Exception e)
        {
            return BadRequest(e.Message);
        }
    }
    
    /// <summary>
    /// Api for customer register
    /// </summary>
    /// <param name="newCustomer"></param>
    /// <returns>return a new customer</returns>
    [HttpPost("register-customer")]
    [AllowAnonymous]
    public async Task<IActionResult> CreateNewCustomer([FromBody] NewCustomer newCustomer)
    {
        try
        {
            var customer = await _userService.CreateNewCustomerAsync(newCustomer);
            return Ok(customer);
        }catch(Exception e)
        {
            return BadRequest(e.Message);
        }
    }
    /// <summary>
    /// Get customer by page
    /// </summary>
    /// <param name="page"></param>
    /// <param name="pageSize"></param>
    /// <returns>list customer</returns>
    [HttpGet("get-customer/page-{page}/pagesize-{pageSize}")]
    public async Task<IActionResult> GetCustomerByPage([FromRoute] int page =1, [FromRoute] int pageSize =20)
    {
        try
        {
            var customers = await _userService.GetCustomerByPageAsync(page, pageSize);
            return Ok(customers);
        }catch(Exception e)
        {
            return BadRequest(e.Message);
        }
    }

    /// <summary>
    /// send a new code
    /// </summary>
    /// <param name="email"></param>
    /// <param name="accountType"></param>
    /// <returns>bool</returns>
    [HttpPost("send-new-code")]
    [AllowAnonymous]
    public async Task<IActionResult> SendNewCodeVerify(string email,string accountType)
    {
        try
        {
            var result = await _userService.SendVerificationCodeBackAsync(email, accountType);
            return Ok(result);
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
    
}