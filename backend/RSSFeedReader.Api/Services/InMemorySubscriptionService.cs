using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.Api.Services;

public sealed class InMemorySubscriptionService : ISubscriptionService
{
    private readonly object _sync = new();
    private readonly List<Subscription> _subscriptions = [];

    public Task<SubscriptionCreateResult> CreateAsync(string feedUrl, CancellationToken cancellationToken = default)
    {
        if (!SubscriptionUrlValidator.TryNormalizeHttpUrl(feedUrl, out var normalizedUrl))
        {
            return Task.FromResult(SubscriptionCreateResult.Failed(SubscriptionErrorCode.InvalidUrl));
        }

        lock (_sync)
        {
            var exists = _subscriptions.Any(x =>
                string.Equals(x.FeedUrl, normalizedUrl, StringComparison.OrdinalIgnoreCase));
            if (exists)
            {
                return Task.FromResult(SubscriptionCreateResult.Failed(SubscriptionErrorCode.DuplicateSubscription));
            }

            var subscription = new Subscription
            {
                Id = Guid.NewGuid(),
                FeedUrl = normalizedUrl,
                CreatedAt = DateTimeOffset.UtcNow
            };

            _subscriptions.Add(subscription);
            return Task.FromResult(SubscriptionCreateResult.Created(subscription));
        }
    }

    public Task<IReadOnlyList<Subscription>> ListAsync(CancellationToken cancellationToken = default)
    {
        lock (_sync)
        {
            var ordered = _subscriptions
                .OrderBy(x => x.CreatedAt)
                .ToArray();

            return Task.FromResult<IReadOnlyList<Subscription>>(ordered);
        }
    }
}
