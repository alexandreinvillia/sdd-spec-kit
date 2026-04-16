using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.Api.Services;

public interface ISubscriptionService
{
    Task<SubscriptionCreateResult> CreateAsync(string feedUrl, CancellationToken cancellationToken = default);

    Task<IReadOnlyList<Subscription>> ListAsync(CancellationToken cancellationToken = default);
}
