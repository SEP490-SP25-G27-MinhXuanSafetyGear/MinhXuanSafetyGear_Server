using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "Admin,Manager")]
public class UserController : ControllerBase
{
    private readonly IUserService _userService;
    public UserController(IUserService userService)
    {
        _userService = userService;
    }
    /// <summary>
    /// only admin can create new employee
    /// </summary>
    /// <param name="newEmployee"></param>
    /// <returns></returns>
    [Authorize(Roles = "Admin")]
    [HttpPost("create-employee")]
    public async Task<IActionResult> CreateUser([FromBody] NewEmployee newEmployee)
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
    /// <returns></returns>
    [Authorize(Roles = "Admin")]
    [HttpPut("update-employee")]
    public async Task<IActionResult> UpdateUser([FromBody] UpdateEmployee updateEmployee)
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
    /// <returns></returns>
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
}