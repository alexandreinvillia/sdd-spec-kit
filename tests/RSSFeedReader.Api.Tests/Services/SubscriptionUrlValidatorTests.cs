using RSSFeedReader.Api.Services;

namespace RSSFeedReader.Api.Tests.Services;

public class SubscriptionUrlValidatorTests
{
    [Theory]
    [InlineData("https://example.com/feed")]
    [InlineData("http://example.com/feed")]
    [InlineData("  https://example.com/feed  ")]
    public void TryNormalizeHttpUrl_WhenUrlIsValid_ReturnsTrue(string input)
    {
        var isValid = SubscriptionUrlValidator.TryNormalizeHttpUrl(input, out var normalized);

        Assert.True(isValid);
        Assert.NotEmpty(normalized);
        Assert.StartsWith("http", normalized, StringComparison.OrdinalIgnoreCase);
    }

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    [InlineData("ftp://example.com/feed")]
    [InlineData("notaurl")]
    public void TryNormalizeHttpUrl_WhenUrlIsInvalid_ReturnsFalse(string input)
    {
        var isValid = SubscriptionUrlValidator.TryNormalizeHttpUrl(input, out var normalized);

        Assert.False(isValid);
        Assert.Equal(string.Empty, normalized);
    }
}
