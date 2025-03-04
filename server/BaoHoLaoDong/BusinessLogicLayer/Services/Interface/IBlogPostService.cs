using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Models;
using BusinessObject.Entities;

namespace BusinessLogicLayer.Services.Interface;

public interface IBlogPostService
{
    Task<BlogPostResponse> CreateNewBlogPostAsync(NewBlogPost newBlogPost);
    Task<Page<BlogPostResponse>?> GetBlogPostByPageAsync(int categoryId=0,int page=1,int pageSize=10);
    Task<BlogPostResponse?> UpdateBlogPostAsync(UpdateBlogPost updateBlogPost);
    Task<List<BlogPostResponse?>> SearchBlogPostAsync(string title);
    Task<bool?> DeleteBlogPostAsync(int id);
    Task<List<BlogCategoryResponse>?> GetBlogCategoriesAsync();
    Task<BlogCategoryResponse?> CreateBlogCategoryAsync(NewBlogCategory blogCategoryRequest);
    Task<BlogCategoryResponse?> UpdateBlogCategoryAsync(UpdateBlogCategory updateBlogCategory);
    Task<int> CountBlogByCategory(int category);
    Task<BlogPostResponse?> GetBlogsByIdAsync(int id);
    Task<List<BlogCategoryResponse>> GetAllCategoriesAsync();
}