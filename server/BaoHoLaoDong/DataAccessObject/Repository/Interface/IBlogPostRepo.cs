using BusinessObject.Entities;

namespace DataAccessObject.Repository.Interface
{
    public interface IBlogPostRepo
    {
        Task<BlogPost?> GetBlogPostByIdAsync(int id);
        Task<List<BlogCategory>> GetAllCategoriesAsync();
        Task<BlogPost?> CreateBlogPostAsync(BlogPost blogPost);
        Task<BlogPost?> UpdateBlogPostAsync(BlogPost blogPost);
        Task<bool> DeleteBlogPostAsync(int id);
        Task<List<BlogPost>?> GetAllBlogPostsAsync();
        Task<List<BlogPost>?> GetBlogPostsPageAsync(int categoryId,int page, int pageSize);
        Task<List<BlogCategory>?> GetBlogCategoriesAsync();
        Task<BlogCategory?> CreateBlogCategoryAsync(BlogCategory blogCategory);
        Task<BlogCategory?> GetBlogCategoryByIdAsync(int id);
        Task<BlogCategory?> UpdateBlogCategoryAsync(BlogCategory? blogCategory);
<<<<<<< Updated upstream
        Task<List<BlogPost>?> SearchBlogPostAsync(string? title = null);
        Task<int> CountBlogByCategory(int category);
=======
        Task<int> CountBlogPostByCategoryAsync(int categoryId);
        Task<List<BlogPost>?> SearchBlogPostAsync(string? title = null);
>>>>>>> Stashed changes
    }
}
