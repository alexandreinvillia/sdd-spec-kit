using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.Api.Services;

public enum SubscriptionErrorCode
{
    InvalidUrl,
    DuplicateSubscription
}

public sealed class SubscriptionCreateResult
{
    private SubscriptionCreateResult(bool success, Subscription? subscription, SubscriptionErrorCode? errorCode)
    {
        Success = success;
        Subscription = subscription;
        ErrorCode = errorCode;
    }

    public bool Success { get; }

    public Subscription? Subscription { get; }

    public SubscriptionErrorCode? ErrorCode { get; }

    public static SubscriptionCreateResult Created(Subscription subscription) =>
        new(success: true, subscription, errorCode: null);

    public static SubscriptionCreateResult Failed(SubscriptionErrorCode errorCode) =>
        new(success: false, subscription: null, errorCode);
}
