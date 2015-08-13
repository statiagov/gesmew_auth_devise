RSpec.configure do |config|
  config.after do
    Gesmew::Ability.abilities.delete(AbilityDecorator) if Gesmew::Ability.abilities.include?(AbilityDecorator)
  end
end

if defined? CanCan::Ability
  class AbilityDecorator
    include CanCan::Ability

    def initialize(user)
      cannot :manage, Gesmew::Order
    end
  end
end
