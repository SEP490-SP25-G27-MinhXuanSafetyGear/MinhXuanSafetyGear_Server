using BusinessObject.Entities;
using DataAccessObject.Dao;
using DataAccessObject.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataAccessObject.Repository
{
    public class UserRepo : IUserRepo
    {
        private readonly CustomerDao _customerDao;
        private readonly EmployeeDao _employeeDao;

        public UserRepo(MinhXuanDatabaseContext context)
        {
            _customerDao = new CustomerDao(context);
            _employeeDao = new EmployeeDao(context);
        }

        #region Customer
        public async Task<Customer?> GetCustomerByIdAsync(int id)
        {
            return await _customerDao.GetByIdAsync(id);
        }

        public async Task<Customer?> GetCustomerByEmailAsync(string email)
        {
            return await _customerDao.GetByEmailAsync(email);
        }

        public async Task<Customer?> GetCustomerByPhoneAsync(string phone)
        {
            return await _customerDao.GetByPhoneAsync(phone); // Call the DAO method
        }

        public async Task<Customer?> CreateCustomerAsync(Customer customer)
        {
            // Check if the customer with the same email already exists
            var existingCustomer = await _customerDao.GetByEmailAsync(customer.Email);
            if (existingCustomer != null)
            {
                throw new ArgumentException("Customer with this email already exists.");
            }

            return await _customerDao.CreateAsync(customer);
        }

        public async Task<Customer?> UpdateCustomerAsync(Customer customer)
        {
            var existingCustomer = await _customerDao.GetByIdAsync(customer.CustomerId);
            if (existingCustomer == null)
            {
                throw new ArgumentException("Customer not found.");
            }

            return await _customerDao.UpdateAsync(customer);
        }

        public async Task<List<Customer>?> GetCustomersPageAsync(int page, int pageSize)
        {
            return await _customerDao.GetPageAsync(page, pageSize);
        }

        public async Task<List<Customer>?> GetAllCustomersAsync()
        {
            return await _customerDao.GetAllAsync();
        }
        #endregion Customer

        #region Employee
        public async Task<Employee?> GetEmployeeByIdAsync(int id)
        {
            return await _employeeDao.GetByIdAsync(id);
        }

        public async Task<Employee?> GetEmployeeByEmailAsync(string email)
        {
            return await _employeeDao.GetEmployeeByEmailAsync(email);
        }

        public async Task<Employee?> GetEmployeeByPhoneAsync(string phone)
        {
            return await _employeeDao.GetEmployeeByPhoneAsync(phone);
        }

        public async Task<Employee?> CreateEmployeeAsync(Employee employee)
        {
            var existingEmployee = await _employeeDao.GetEmployeeByEmailAsync(employee.Email);
            if (existingEmployee != null)
            {
                throw new ArgumentException("Employee with this email already exists.");
            }

            return await _employeeDao.CreateAsync(employee);
        }

        public async Task<Employee?> UpdateEmployeeAsync(Employee employee)
        {
            var existingEmployee = await _employeeDao.GetByIdAsync(employee.EmployeeId);
            if (existingEmployee == null)
            {
                throw new ArgumentException("Employee not found.");
            }

            return await _employeeDao.UpdateAsync(employee);
        }

        public async Task<List<Employee>?> GetEmployeesPageAsync(int page, int pageSize)
        {
            return await _employeeDao.GetPageAsync(page, pageSize);
        }

        public async Task<List<Employee>?> GetAllEmployeesAsync()
        {
            return await _employeeDao.GetAllAsync();
        }
        #endregion Employee
    }
}
