using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.UI.Models;

public sealed class SubscriptionViewModel
{
    public Guid Id { get; init; }

    public string FeedUrl { get; init; } = string.Empty;

    public DateTimeOffset CreatedAt { get; init; }

    public static SubscriptionViewModel FromContract(Subscription subscription)
    {
        return new SubscriptionViewModel
        {
            Id = subscription.Id,
            FeedUrl = subscription.FeedUrl,
            CreatedAt = subscription.CreatedAt
        };
    }
}
