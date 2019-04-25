module Webui::Staging::ExcludedRequestsHelper
  def excluded_requests_remote_url(staging_workflow_id)
    { source: staging_workflow_excluded_requests_path(staging_workflow_id, format: :json) }
  end
end
