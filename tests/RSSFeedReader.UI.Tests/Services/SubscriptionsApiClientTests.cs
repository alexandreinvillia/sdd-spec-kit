using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Text;
using RSSFeedReader.Contracts.Models;
using RSSFeedReader.UI.Services;

namespace RSSFeedReader.UI.Tests.Services;

public class SubscriptionsApiClientTests
{
    [Fact]
    public async Task CreateAsync_WhenApiReturnsCreated_ReturnsSubscription()
    {
        var payload = """
        {
          "id": "5f15c4f4-b42b-49a2-bf8f-a69d12345789",
          "feedUrl": "https://example.com/feed",
          "createdAt": "2026-04-16T10:00:00Z"
        }
        """;

        var client = CreateHttpClient(_ => new HttpResponseMessage(HttpStatusCode.Created)
        {
            Content = new StringContent(payload, Encoding.UTF8, "application/json")
        });
        var sut = new SubscriptionsApiClient(client);

        var result = await sut.CreateAsync("https://example.com/feed");

        Assert.Equal("https://example.com/feed", result.FeedUrl);
    }

    [Fact]
    public async Task CreateAsync_WhenApiReturnsError_ThrowsApiErrorException()
    {
        var payload = JsonContent.Create(new ErrorResponse
        {
            Code = "INVALID_URL",
            Message = "URL invalida"
        });

        var client = CreateHttpClient(_ => new HttpResponseMessage(HttpStatusCode.BadRequest)
        {
            Content = payload
        });
        var sut = new SubscriptionsApiClient(client);

        var ex = await Assert.ThrowsAsync<ApiErrorException>(() => sut.CreateAsync("invalid"));

        Assert.Equal("INVALID_URL", ex.Code);
    }

    private static HttpClient CreateHttpClient(Func<HttpRequestMessage, HttpResponseMessage> responseFactory)
    {
        var handler = new StubHttpMessageHandler(responseFactory);
        return new HttpClient(handler)
        {
            BaseAddress = new Uri("http://localhost:5151/api/")
        };
    }

    private sealed class StubHttpMessageHandler : HttpMessageHandler
    {
        private readonly Func<HttpRequestMessage, HttpResponseMessage> _responseFactory;

        public StubHttpMessageHandler(Func<HttpRequestMessage, HttpResponseMessage> responseFactory)
        {
            _responseFactory = responseFactory;
        }

        protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            return Task.FromResult(_responseFactory(request));
        }
    }
}
