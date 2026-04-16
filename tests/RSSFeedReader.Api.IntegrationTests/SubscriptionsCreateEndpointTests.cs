using System.Net;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc.Testing;
using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.Api.IntegrationTests;

public class SubscriptionsCreateEndpointTests
{

    [Fact]
    public async Task PostSubscriptions_WithValidUrl_ReturnsCreated()
    {
        using var factory = new WebApplicationFactory<Program>();
        using var httpClient = factory.CreateClient();

        var response = await httpClient.PostAsJsonAsync("/api/subscriptions", new CreateSubscriptionRequest
        {
            FeedUrl = "https://example.com/feed"
        });

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<Subscription>();
        Assert.NotNull(body);
        Assert.Equal("https://example.com/feed", body!.FeedUrl);
    }

    [Fact]
    public async Task PostSubscriptions_WithInvalidUrl_ReturnsBadRequest()
    {
        using var factory = new WebApplicationFactory<Program>();
        using var httpClient = factory.CreateClient();

        var response = await httpClient.PostAsJsonAsync("/api/subscriptions", new CreateSubscriptionRequest
        {
            FeedUrl = "ftp://example.com/feed"
        });

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<ErrorResponse>();
        Assert.NotNull(body);
        Assert.Equal("INVALID_URL", body!.Code);
    }

    [Fact]
    public async Task PostSubscriptions_WithDuplicateUrl_ReturnsConflict()
    {
        using var factory = new WebApplicationFactory<Program>();
        using var httpClient = factory.CreateClient();

        await httpClient.PostAsJsonAsync("/api/subscriptions", new CreateSubscriptionRequest
        {
            FeedUrl = "https://duplicate.example.com/feed"
        });

        var response = await httpClient.PostAsJsonAsync("/api/subscriptions", new CreateSubscriptionRequest
        {
            FeedUrl = "https://duplicate.example.com/feed"
        });

        Assert.Equal(HttpStatusCode.Conflict, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<ErrorResponse>();
        Assert.NotNull(body);
        Assert.Equal("DUPLICATE_SUBSCRIPTION", body!.Code);
    }
}
