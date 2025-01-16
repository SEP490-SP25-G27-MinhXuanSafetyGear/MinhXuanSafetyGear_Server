using System;
using System.Collections.Generic;

namespace BusinessObject.Entities;

public partial class Category
{
    public int CategoryId { get; set; }

    public string CategoryName { get; set; } = null!;

    public string Description { get; set; } = null!;
}
