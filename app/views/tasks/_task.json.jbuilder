json.extract! task, :id, :name, :priority, :project_id, :deadline, :done, :created_at, :updated_at, :user_id
json.url task_url(task, format: :json)
