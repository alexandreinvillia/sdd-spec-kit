namespace RSSFeedReader.Api.Services;

public static class SubscriptionUrlValidator
{
    public static bool TryNormalizeHttpUrl(string? value, out string normalized)
    {
        normalized = string.Empty;

        if (string.IsNullOrWhiteSpace(value))
        {
            return false;
        }

        var trimmed = value.Trim();
        if (!Uri.TryCreate(trimmed, UriKind.Absolute, out var uri))
        {
            return false;
        }

        if (uri.Scheme is not ("http" or "https"))
        {
            return false;
        }

        normalized = uri.AbsoluteUri;
        return true;
    }
}
