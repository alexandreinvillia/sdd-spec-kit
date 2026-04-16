using RSSFeedReader.Api.Services;

namespace RSSFeedReader.Api.Tests.Services;

public class InMemorySubscriptionServiceCreateTests
{
    [Fact]
    public async Task CreateAsync_WithValidUrl_CreatesSubscription()
    {
        var sut = new InMemorySubscriptionService();

        var result = await sut.CreateAsync("https://example.com/feed");

        Assert.True(result.Success);
        Assert.NotNull(result.Subscription);
        Assert.Equal("https://example.com/feed", result.Subscription!.FeedUrl);
    }

    [Fact]
    public async Task CreateAsync_WithDuplicateUrl_ReturnsDuplicateError()
    {
        var sut = new InMemorySubscriptionService();

        await sut.CreateAsync("https://example.com/feed");
        var result = await sut.CreateAsync("https://example.com/feed");

        Assert.False(result.Success);
        Assert.Equal(SubscriptionErrorCode.DuplicateSubscription, result.ErrorCode);
    }

    [Fact]
    public async Task CreateAsync_WithInvalidUrl_ReturnsInvalidUrlError()
    {
        var sut = new InMemorySubscriptionService();

        var result = await sut.CreateAsync("ftp://example.com/feed");

        Assert.False(result.Success);
        Assert.Equal(SubscriptionErrorCode.InvalidUrl, result.ErrorCode);
    }
}
