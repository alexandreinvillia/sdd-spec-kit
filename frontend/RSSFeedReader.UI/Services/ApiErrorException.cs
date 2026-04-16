namespace RSSFeedReader.UI.Services;

public sealed class ApiErrorException : Exception
{
    public ApiErrorException(string code, string message)
        : base(message)
    {
        Code = code;
    }

    public string Code { get; }
}
