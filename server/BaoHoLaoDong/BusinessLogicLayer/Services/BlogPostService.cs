using AutoMapper;
using BusinessLogicLayer.Mappings.RequestDTO;
using BusinessLogicLayer.Mappings.ResponseDTO;
using BusinessLogicLayer.Models;
using BusinessLogicLayer.Services.Interface;
using BusinessObject.Entities;
using DataAccessObject.Repository;
using DataAccessObject.Repository.Interface;
using Microsoft.Extensions.Logging;

namespace BusinessLogicLayer.Services;

public class BlogPostService : IBlogPostService
{
    private readonly IBlogPostRepo _blogPostRepo;
    private readonly string _imagePathBlog;
    private readonly IMapper _mapper;
    private readonly ILogger<BlogPostService> _logger;
    public BlogPostService(MinhXuanDatabaseContext context, string imagePathBlog, IMapper mapper, ILogger<BlogPostService> logger)
    {
        _blogPostRepo = new BlogPostRepo(context);
        _imagePathBlog = imagePathBlog;
        _mapper = mapper;
        _logger = logger;
    }
    public async Task<List<BlogCategoryResponse>> GetAllCategoriesAsync()
    {
        var response = await _blogPostRepo.GetBlogCategoriesAsync(); 
        return _mapper.Map<List<BlogCategoryResponse>>(response);
    }

    public async Task<BlogPostResponse> CreateNewBlogPostAsync(NewBlogPost newBlogPost)
    {
        try
        {
            var categories = await _blogPostRepo.GetAllCategoriesAsync();
            var blogPost = _mapper.Map<BlogPost>(newBlogPost);

            if (!string.IsNullOrEmpty(newBlogPost.ImageURL))
            {
                blogPost.FileName = newBlogPost.ImageURL;
            }
            else
            {
                return null; 
            }

            blogPost = await _blogPostRepo.CreateBlogPostAsync(blogPost);

            var response = _mapper.Map<BlogPostResponse>(blogPost);
           

            return response;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while saving blog post");
            throw;
        }
    }
    public async Task<Page<BlogPostResponse>?> GetBlogPostByPageAsync(int categoryId = 0, int page = 1, int pageSize = 10)
    {
        var blogs = await _blogPostRepo.GetBlogPostsPageAsync(categoryId, page, pageSize);
        var totalBlog = await _blogPostRepo.CountBlogByCategory(categoryId);
        var blogPosts = _mapper.Map<List<BlogPostResponse>>(blogs);
        var pageResult = new Page<BlogPostResponse>(blogPosts, page, pageSize, totalBlog);
        _logger.LogInformation("getBlogs", pageResult);
        return pageResult;
    }
    
    public async Task<int> CountBlogByCategory(int category)
    {
        return await _blogPostRepo.CountBlogByCategory(category);
    }

    public async Task<BlogPostResponse?> UpdateBlogPostAsync(UpdateBlogPost updateBlogPost)
    {
        try
        {
            var blogPostExit = await _blogPostRepo.GetBlogPostByIdAsync(updateBlogPost.PostId);
            _mapper.Map(updateBlogPost, blogPostExit);
            var file = updateBlogPost.File;
            if (file != null && file.Length > 0)
            {
                var fileName = blogPostExit.FileName;
                var pathImage = Path.Combine(_imagePathBlog, fileName);
                using (var stream = new FileStream(pathImage, FileMode.Create))
                {
                    await file.CopyToAsync(stream);
                }
            }

            blogPostExit = await _blogPostRepo.UpdateBlogPostAsync(blogPostExit);
            return _mapper.Map<BlogPostResponse>(blogPostExit);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while update blog");
            throw;
        }
    }

    public async Task<bool?> DeleteBlogPostAsync(int id)
    {
        try
        {
            var blogPostExit = await _blogPostRepo.GetBlogPostByIdAsync(id);
            var fileName = blogPostExit.FileName;
            var pathImage = Path.Combine(_imagePathBlog, fileName);
            var result = await _blogPostRepo.DeleteBlogPostAsync(id);
            if (File.Exists(pathImage) && result)
            {
                File.Delete(pathImage);
            }

            return result;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while delete blog");
            throw;
        }
    }
    public async Task<BlogPostResponse?> GetBlogsByIdAsync(int id)
    {
        try
        {
            var blogs = await _blogPostRepo.GetBlogPostByIdAsync(id);
            return _mapper.Map<BlogPostResponse>(blogs);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while get product by id");
            throw;
        }
    }


    public async Task<List<BlogCategoryResponse>?> GetBlogCategoriesAsync()
    {
        try
        {
            var blogCategories = await _blogPostRepo.GetBlogCategoriesAsync();
            return _mapper.Map<List<BlogCategoryResponse>>(blogCategories);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while get blog categories");
            throw;
        }
    }
    public async Task<BlogCategoryResponse?> CreateBlogCategoryAsync(NewBlogCategory blogCategoryRequest)
    {
        try
        {
            var blogCategory = _mapper.Map<BlogCategory>(blogCategoryRequest);
            blogCategory = await _blogPostRepo.CreateBlogCategoryAsync(blogCategory);
            return _mapper.Map<BlogCategoryResponse>(blogCategory);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while create blog category");
            throw;
        }
    }
    public async Task<BlogCategoryResponse?> UpdateBlogCategoryAsync(UpdateBlogCategory updateBlogCategory)
    {
        try
        {
            var blogCategory = await _blogPostRepo.GetBlogCategoryByIdAsync(updateBlogCategory.Id);
            _mapper.Map(updateBlogCategory, blogCategory);
            blogCategory = await _blogPostRepo.UpdateBlogCategoryAsync(blogCategory);
            return _mapper.Map<BlogCategoryResponse>(blogCategory);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while update blog category");
            throw;
        }
    }
    public async Task<List<BlogPostResponse>?> SearchBlogPostAsync(string title)
    {
        try
        {
            var blogPosts = await _blogPostRepo.SearchBlogPostAsync(title);
            return _mapper.Map<List<BlogPostResponse>>(blogPosts);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error while searching blog posts");
            throw;
        }
    }
    public static string RemoveDiacritics(string text)
    {
        string[] vietnameseSigns = new string[]
        {
            "aáàảãạăắằẳẵặâấầẩẫậ", "AÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ",
            "dđ", "DĐ",
            "eéèẻẽẹêếềểễệ", "EÉÈẺẼẸÊẾỀỂỄỆ",
            "iíìỉĩị", "IÍÌỈĨỊ",
            "oóòỏõọôốồổỗộơớờởỡợ", "OÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ",
            "uúùủũụưứừửữự", "UÚÙỦŨỤƯỨỪỬỮỰ",
            "yýỳỷỹỵ", "YÝỲỶỸỴ"
        };

        foreach (var sign in vietnameseSigns)
        {
            foreach (var c in sign.Substring(1))
            {
                text = text.Replace(c, sign[0]);
            }
        }
        return text;
    }

}