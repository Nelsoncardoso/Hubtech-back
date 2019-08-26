shared_examples_for :deny_without_authorization do |method_type, action, params = {}|
    it 'returns unauthrorized(401) request' do
        case method_type
        when :get
            get action
        when :post
            post action
        when :put
            put action
        when :delete
            delete action
        end

        expect(response.status).to eql(302)
    end
end
