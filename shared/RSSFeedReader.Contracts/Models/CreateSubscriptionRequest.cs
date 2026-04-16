namespace RSSFeedReader.Contracts.Models;

public sealed class CreateSubscriptionRequest
{
    public string FeedUrl { get; init; } = string.Empty;
}
