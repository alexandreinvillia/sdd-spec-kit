using RSSFeedReader.Api.Services;

namespace RSSFeedReader.Api.Tests.Services;

public class InMemorySubscriptionServiceListTests
{
    [Fact]
    public async Task ListAsync_WhenEmpty_ReturnsEmptyCollection()
    {
        var sut = new InMemorySubscriptionService();

        var result = await sut.ListAsync();

        Assert.Empty(result);
    }

    [Fact]
    public async Task ListAsync_ReturnsSubscriptionsOrderedByCreatedAt()
    {
        var sut = new InMemorySubscriptionService();

        await sut.CreateAsync("https://example.com/b");
        await Task.Delay(10);
        await sut.CreateAsync("https://example.com/a");

        var result = await sut.ListAsync();

        Assert.Equal(2, result.Count);
        Assert.True(result[0].CreatedAt <= result[1].CreatedAt);
    }
}
