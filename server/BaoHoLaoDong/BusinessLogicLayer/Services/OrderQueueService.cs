using System.Collections.Concurrent;

using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Services.Interface;

namespace BusinessLogicLayer.Services;

public class OrderQueueService : IOrderQueueService
{
    private readonly ConcurrentQueue<NewOrder> _orderQueue = new();
    
    public Task EnqueueOrder(NewOrder order)
    {
        _orderQueue.Enqueue(order);
        return Task.CompletedTask;
    }

    public Task<NewOrder?> DequeueOrder()
    {
        bool success = _orderQueue.TryDequeue(out var order);
        return Task.FromResult(order);
    }
}