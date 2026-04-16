using System.Net;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc.Testing;
using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.Api.IntegrationTests;

public class SubscriptionsListEndpointTests
{

    [Fact]
    public async Task GetSubscriptions_WhenEmpty_ReturnsEmptyArray()
    {
        using var factory = new WebApplicationFactory<Program>();
        using var httpClient = factory.CreateClient();

        var response = await httpClient.GetAsync("/api/subscriptions");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<List<Subscription>>();
        Assert.NotNull(body);
        Assert.Empty(body!);
    }

    [Fact]
    public async Task GetSubscriptions_WhenItemsExist_ReturnsAllItems()
    {
        using var factory = new WebApplicationFactory<Program>();
        using var httpClient = factory.CreateClient();

        await httpClient.PostAsJsonAsync("/api/subscriptions", new CreateSubscriptionRequest
        {
            FeedUrl = "https://list.example.com/1"
        });
        await httpClient.PostAsJsonAsync("/api/subscriptions", new CreateSubscriptionRequest
        {
            FeedUrl = "https://list.example.com/2"
        });

        var response = await httpClient.GetAsync("/api/subscriptions");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<List<Subscription>>();
        Assert.NotNull(body);
        Assert.True(body!.Count >= 2);
    }
}
