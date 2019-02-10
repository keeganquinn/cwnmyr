# frozen_string_literal: true

# This concern includes methods to construct responses to common request types.
module Response
  def save_and_respond(thing, status, msg)
    if request.format.html?
      if thing.save
        redirect_to thing, notice: t(msg, thing: thing.model_name.human)
      end
    else
      thing.save!
      render status: status, location: thing
    end
  end

  def destroy_and_respond(thing, parent)
    thing.destroy
    if request.format.html?
      redirect_to(parent,
                  notice: t(:delete_success, thing: thing.model_name.human))
    else
      head :no_content
    end
  end
end
