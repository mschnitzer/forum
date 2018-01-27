module ApplicationHelper
  def not_found
    respond_to do |format|
      format.html { render 'shared/not_found', status: :not_found }
    end

    throw :halt
  end

  def permission_denied
    respond_to do |format|
      format.html { render 'shared/permission_denied', status: :forbidden }
    end

    throw :halt
  end
end
