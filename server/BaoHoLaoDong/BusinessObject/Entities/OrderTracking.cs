using System;
using System.Collections.Generic;

namespace BusinessObject.Entities;

public partial class OrderTracking
{
    public int TrackingId { get; set; }

    public int OrderId { get; set; }

    public string Status { get; set; } = null!;

    public DateTime UpdateDate { get; set; }

    public string? Comment { get; set; }

    public int UpdatedBy { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual Order Order { get; set; } = null!;

    public virtual Employee UpdatedByNavigation { get; set; } = null!;
}
