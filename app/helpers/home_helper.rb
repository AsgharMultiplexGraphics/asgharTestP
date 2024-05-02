module HomeHelper
    def nav_classes
        return "navbar navbar-expand-lg navbar-dark bg-dark fixed-top mb-20" if !user_signed_in?

        if current_user.cashier?
         "navbar navbar-expand-lg navbar-dark bg-primary fixed-top mb-10"
        elsif current_user.manager?
         "navbar navbar-expand-lg navbar-dark bg-success fixed-top mb-10"
        else 
         "navbar navbar-expand-lg navbar-dark bg-dark fixed-top mb-10"
        end             
    end

end
