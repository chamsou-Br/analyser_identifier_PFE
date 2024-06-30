class TransactionService
    def initialize
      @transaction_manager = TransactionManager.new
    end
  
    def initiate_transaction(product, buyerId)
        buyer = Buyer.find_buyer(buyerId)
      @transaction_manager.initiate_transaction_manager(product, buyer)
    end
  
    def process_payment(amount)
      @transaction_manager.process_payment_manager(amount)
    end
  
    def confirm_transaction_mnager(transaction_id)
      @transaction_manager.confirm_transaction(transaction_id)
      currentUser.graphs.find(1)
    end

    def find_transaction
      Document.find(1)
    end
  end