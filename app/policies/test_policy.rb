class CompanyPolicy < ApplicationPolicy
  def initialize(guide, *args)
    @guide = guide
    @some, @some2 = *args
  end

  def create?
    puts ">>>CompanyPolicy#create?"
    puts ">>> guide: #{@guide}, some: #{@some}, some2: #{@some2} "
    # guide: #<Guide:0x0000562786ac2a98>, some: test, some2: test2
    @guide.role_permissions['companies'] == 'true' || @guide.full_access
  end

  # in controller
  # authorize([:s_guide, company]) -- вложенность
  # authorize pundit_user, policy_class: CompanyPolicy
  # authorize pundit_user, :create?, policy_class: CompanyPolicy
  # CompanyPolicy.new(pundit_user, 'test', 'test2').create?
end