using System.Net.Http.Json;
using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.UI.Services;

public sealed class SubscriptionsApiClient
{
    private readonly HttpClient _httpClient;

    public SubscriptionsApiClient(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<IReadOnlyList<Subscription>> ListAsync(CancellationToken cancellationToken = default)
    {
        var result = await _httpClient.GetFromJsonAsync<List<Subscription>>("subscriptions", cancellationToken);
        return result ?? [];
    }

    public async Task<Subscription> CreateAsync(string feedUrl, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.PostAsJsonAsync("subscriptions", new CreateSubscriptionRequest
        {
            FeedUrl = feedUrl
        }, cancellationToken);

        if (response.IsSuccessStatusCode)
        {
            var created = await response.Content.ReadFromJsonAsync<Subscription>(cancellationToken: cancellationToken);
            if (created is null)
            {
                throw new InvalidOperationException("A API retornou sucesso sem payload de assinatura.");
            }

            return created;
        }

        var error = await response.Content.ReadFromJsonAsync<ErrorResponse>(cancellationToken: cancellationToken);
        throw new ApiErrorException(error?.Code ?? "UNKNOWN_ERROR", error?.Message ?? "Falha ao criar assinatura.");
    }
}
