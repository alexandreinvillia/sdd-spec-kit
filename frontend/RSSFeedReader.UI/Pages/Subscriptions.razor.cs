using Microsoft.AspNetCore.Components;
using RSSFeedReader.UI.Models;
using RSSFeedReader.UI.Services;

namespace RSSFeedReader.UI.Pages;

public partial class Subscriptions : ComponentBase
{
    [Inject]
    public SubscriptionsApiClient ApiClient { get; set; } = default!;

    public string FeedUrl { get; set; } = string.Empty;

    public string? ErrorMessage { get; set; }

    public bool IsLoading { get; set; }

    public bool IsSubmitting { get; set; }

    public List<SubscriptionViewModel> SubscriptionList { get; } = [];

    protected override async Task OnInitializedAsync()
    {
        await LoadSubscriptionsAsync();
    }

    public async Task CreateSubscriptionAsync()
    {
        ErrorMessage = null;
        IsSubmitting = true;

        try
        {
            var created = await ApiClient.CreateAsync(FeedUrl);
            SubscriptionList.Add(SubscriptionViewModel.FromContract(created));
            FeedUrl = string.Empty;
        }
        catch (ApiErrorException ex) when (ex.Code is "INVALID_URL" or "DUPLICATE_SUBSCRIPTION")
        {
            ErrorMessage = ex.Message;
        }
        catch
        {
            ErrorMessage = "Falha inesperada ao criar assinatura.";
        }
        finally
        {
            IsSubmitting = false;
        }
    }

    private async Task LoadSubscriptionsAsync()
    {
        ErrorMessage = null;
        IsLoading = true;

        try
        {
            var items = await ApiClient.ListAsync();
            SubscriptionList.Clear();
            SubscriptionList.AddRange(items.Select(SubscriptionViewModel.FromContract));
        }
        catch
        {
            ErrorMessage = "Falha ao carregar assinaturas.";
        }
        finally
        {
            IsLoading = false;
        }
    }
}
