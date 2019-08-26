class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :end_time, :created_at
end
