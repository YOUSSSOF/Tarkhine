class Utils:
    @staticmethod
    def make_phone_number_standard(phone_number: str):
        
        if phone_number.startswith('98'):
            return phone_number

        elif phone_number.startswith('0'):
            numbers = list(phone_number)
            numbers[0] = ''
            phone_number = ''.join(numbers)
            phone_number = '98'+phone_number

        elif phone_number.startswith('9'):
            phone_number = '98'+phone_number

        return phone_number
