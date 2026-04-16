namespace RSSFeedReader.Contracts.Models;

public sealed class ErrorResponse
{
    public string Code { get; init; } = string.Empty;

    public string Message { get; init; } = string.Empty;

    public string? TraceId { get; init; }
}
