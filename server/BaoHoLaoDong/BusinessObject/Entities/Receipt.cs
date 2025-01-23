using System;
using System.Collections.Generic;

namespace BusinessObject.Entities;

public partial class Receipt
{
    public int ReceiptId { get; set; }

    public int OrderId { get; set; }

    public string ReceiptNumber { get; set; } = null!;

    public decimal Amount { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public string? VnPayTransactionCode { get; set; }

    public string? VnPayTransactionStatus { get; set; }

    public DateTime? VnPayPaymentTime { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual Order Order { get; set; } = null!;
}
