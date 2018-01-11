module Cloud
  module Params
    class Ec2
      include ActiveModel::Validations
      include ActiveModel::Model

      attr_accessor :region, :virtualization_type, :ami_name
      validates :region, presence: true, inclusion: {
        in: ::Cloud::Ec2::Configuration::REGIONS.map(&:second), message: "'%{value}' is not a valid EC2 region"
      }
      validates :virtualization_type, inclusion: {
        in: ::Cloud::Ec2::Configuration::VIRTUALIZATION_TYPES.map(&:second), message: "'%{value}' is not a valid EC2 virtualization type"
      }
      validates :ami_name, presence: true, length: { maximum: 100 }
      validate :valid_ami_name

      def self.build(params)
        new(params.slice(:region, :virtualization_type, :ami_name))
      end

      private

      def valid_ami_name
        return if Project.valid_name?(ami_name)
        errors.add(:ami_name, "'#{ami_name}' is not a valid ami name (only letters, numbers, dots and hyphens)")
      end
    end
  end
end
