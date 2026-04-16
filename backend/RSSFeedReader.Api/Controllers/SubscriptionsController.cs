using Microsoft.AspNetCore.Mvc;
using RSSFeedReader.Api.Services;
using RSSFeedReader.Contracts.Models;

namespace RSSFeedReader.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class SubscriptionsController : ControllerBase
{
    private readonly ISubscriptionService _subscriptionService;

    public SubscriptionsController(ISubscriptionService subscriptionService)
    {
        _subscriptionService = subscriptionService;
    }

    [HttpGet]
    [ProducesResponseType(typeof(List<Subscription>), StatusCodes.Status200OK)]
    public async Task<ActionResult<IReadOnlyList<Subscription>>> ListSubscriptions(CancellationToken cancellationToken)
    {
        var subscriptions = await _subscriptionService.ListAsync(cancellationToken);
        return Ok(subscriptions);
    }

    [HttpPost]
    [ProducesResponseType(typeof(Subscription), StatusCodes.Status201Created)]
    [ProducesResponseType(typeof(ErrorResponse), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ErrorResponse), StatusCodes.Status409Conflict)]
    public async Task<ActionResult<Subscription>> CreateSubscription(
        [FromBody] CreateSubscriptionRequest request,
        CancellationToken cancellationToken)
    {
        var result = await _subscriptionService.CreateAsync(request.FeedUrl, cancellationToken);
        if (result.Success && result.Subscription is not null)
        {
            return Created("/api/subscriptions", result.Subscription);
        }

        return result.ErrorCode switch
        {
            SubscriptionErrorCode.InvalidUrl => BadRequest(ToErrorResponse(
                code: "INVALID_URL",
                message: "A URL informada deve ser absoluta e usar HTTP ou HTTPS.")),
            SubscriptionErrorCode.DuplicateSubscription => Conflict(ToErrorResponse(
                code: "DUPLICATE_SUBSCRIPTION",
                message: "A URL informada ja foi cadastrada.")),
            _ => StatusCode(StatusCodes.Status500InternalServerError, ToErrorResponse(
                code: "UNKNOWN_ERROR",
                message: "Erro inesperado ao criar assinatura."))
        };
    }

    private ErrorResponse ToErrorResponse(string code, string message)
    {
        return new ErrorResponse
        {
            Code = code,
            Message = message,
            TraceId = HttpContext.TraceIdentifier
        };
    }
}
