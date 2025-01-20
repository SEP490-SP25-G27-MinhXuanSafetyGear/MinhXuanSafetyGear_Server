using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer.Mappings.ResponseDTO
{
    public class ReceiptResponse
    {
        public int ReceiptId { get; set; }

        public string ReceiptNumber { get; set; } = null!;

        public decimal Amount { get; set; }

        public string PaymentMethod { get; set; } = null!;

        public string? VnPayTransactionCode { get; set; }

        public string? VnPayTransactionStatus { get; set; }

        public DateTime? VnPayPaymentTime { get; set; }

        public DateTime CreatedAt { get; set; }

        public string Status { get; set; } = null!;
    }
}
