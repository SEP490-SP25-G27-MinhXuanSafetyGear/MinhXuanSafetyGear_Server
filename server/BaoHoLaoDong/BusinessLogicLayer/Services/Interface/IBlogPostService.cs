﻿using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Models;

namespace BusinessLogicLayer.Services.Interface;

public interface IBlogPostService
{
    Task<BlogPostResponse> CreateNewBlogPostAsync(NewBlogPost newBlogPost);
    Task<Page<BlogPostResponse>?> GetBlogPostByPageAsync(int categoryId=0,int page=0,int pageSize=5);
    Task<BlogPostResponse?> UpdateBlogPostAsync(UpdateBlogPost updateBlogPost);
    Task<bool?> DeleteBlogPostAsync(int id);
    Task<List<BlogCategoryResponse>?> GetBlogCategoriesAsync();
    Task<BlogCategoryResponse?> CreateBlogCategoryAsync(NewBlogCategory blogCategoryRequest);
    Task<BlogCategoryResponse?> UpdateBlogCategoryAsync(UpdateBlogCategory updateBlogCategory);
    Task<List<BlogPostResponse?>> SearchBlogPostAsync(string title);
    Task<BlogPostResponse?> GetBlogPostByIdAsync(int id);
    Task<BlogPostResponse?> GetBlogPostBySlugAsync(string slug);
    Task<List<BlogPostResponse>?> GetBlogPostBySlugCategoryAsync(string slug);
}