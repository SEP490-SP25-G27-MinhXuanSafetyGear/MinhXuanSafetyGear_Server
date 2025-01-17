using BusinessObject.Entities;
using DataAccessObject.Dao;
using DataAccessObject.Repository.Interface;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DataAccessObject.Repository
{
    public class OrderRepo : IOrderRepo
    {
        private readonly OrderDao _orderDao;
        private readonly OrderDetailDao _orderDetailDao;

        public OrderRepo(MinhXuanDatabaseContext context)
        {
            _orderDao = new OrderDao(context);
            _orderDetailDao = new OrderDetailDao(context);
        }

        #region Order 

        public async Task<Order?> GetOrderByIdAsync(int id)
        {
            return await _orderDao.GetByIdAsync(id);
        }

        public async Task<Order?> CreateOrderAsync(Order order)
        {
            return await _orderDao.CreateAsync(order);
        }

        public async Task<Order?> UpdateOrderAsync(Order order)
        {
            return await _orderDao.UpdateAsync(order);
        }

        public async Task<bool> DeleteOrderAsync(int id)
        {
            return await _orderDao.DeleteAsync(id);
        }

        public async Task<List<Order>?> GetAllOrdersAsync()
        {
            return await _orderDao.GetAllAsync();
        }

        public async Task<List<Order>?> GetOrdersPageAsync(int page, int pageSize)
        {
            return await _orderDao.GetPageAsync(page, pageSize);
        }

        #endregion Order 

        #region OrderDetail 

        public async Task<OrderDetail?> GetOrderDetailByIdAsync(int orderDetailId)
        {
            return await _orderDetailDao.GetByIdAsync(orderDetailId);
        }

        public async Task<OrderDetail?> CreateOrderDetailAsync(OrderDetail orderDetail)
        {
            return await _orderDetailDao.CreateAsync(orderDetail);
        }

        public async Task<OrderDetail?> UpdateOrderDetailAsync(OrderDetail orderDetail)
        {
            return await _orderDetailDao.UpdateAsync(orderDetail);
        }

        public async Task<bool> DeleteOrderDetailAsync(int orderDetailId)
        {
            return await _orderDetailDao.DeleteAsync(orderDetailId);
        }

        public async Task<List<OrderDetail>?> GetOrderDetailsByOrderIdAsync(int orderId)
        {
            return await _orderDetailDao.GetByOrderIdAsync(orderId);
        }

        #endregion OrderDetail 
    }
}
