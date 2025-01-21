using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Services;
using BusinessLogicLayer.Services.Interface;
using DataAccessObject.Repository.Interface;
using Google.Apis.Auth;
using Microsoft.AspNetCore.Mvc;

namespace ManagementAPI.Controllers;
[ApiController]
[Route("api/[controller]")]
public class AuthenticationController : ControllerBase
{
    private readonly IUserService _userService;
    private readonly TokenService _tokenService;

    public AuthenticationController(IUserService userService , TokenService tokenService)
    {
        _userService = userService;
        _tokenService = tokenService;
    }

    [HttpPost("authenticate/loginby-email-password")]
    public async Task<IActionResult> LoginByPassword([FromBody] FormLogin formLogin)
    {
        try
        {
            var user = await _userService.EmployeeLoginByEmailAndPasswordAsync(formLogin);
            if (user != null)
            {
                var token = _tokenService.GenerateJwtToken(user.Email, user.EmployeeId, user.Role);
                return Ok(new {token = token,role = user.Role});
            }
            else
            {
                return Ok("Login false");
            }
        }catch(Exception e)
        {
            return BadRequest(e.Message);
        }
    }
    // API xác thực Google
    [HttpPost("authenticate/loginby-google")]
    public async Task<IActionResult> LoginByGoogle([FromBody] string googleToken)
    {
        try
        {
            var payload = await ValidateGoogleTokenAsync(googleToken);
            if (payload == null)
            {
                return Unauthorized("Invalid Google token.");
            }
            var user = await _userService.GetEmployeeByEmailAsync(payload.Email);
            if (user == null)
            {
                return Unauthorized("User not found.");
            }
            var token = _tokenService.GenerateJwtToken(user.Email, user.EmployeeId, user.Role);
            return Ok(new { token });
        }
        catch (Exception e)
        {
            return BadRequest(e.Message);
        }
    }

    // Phương thức xác thực token của Google
    private async Task<GoogleJsonWebSignature.Payload?> ValidateGoogleTokenAsync(string googleToken)
    {
        try
        {
            var validPayload = await GoogleJsonWebSignature.ValidateAsync(googleToken);
            return validPayload;
        }
        catch (Exception ex)
        {
            Console.WriteLine("Google token validation failed: " + ex.Message);
            return null;
        }
    }
}