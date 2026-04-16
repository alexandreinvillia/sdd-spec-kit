namespace RSSFeedReader.Contracts.Models;

public sealed class Subscription
{
    public Guid Id { get; init; }

    public string FeedUrl { get; init; } = string.Empty;

    public DateTimeOffset CreatedAt { get; init; }
}
