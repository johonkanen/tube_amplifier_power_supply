import re
from typing import Dict, List

class VHDLParser:
    def __init__(self, filepath: str):
        self.filepath = filepath
        self.constants = self._parse_vhdl_file()

    def _parse_vhdl_file(self) -> Dict[str, int]:
        constants = {}
        with open(self.filepath, 'r') as file:
            content = file.read()

        # Regular expression to match constant declarations
        pattern = re.compile(r'constant\s+(\w+)\s*:\s*natural\s*:=\s*(\d+)\s*;', re.IGNORECASE)
        matches = pattern.findall(content)
        for name, value in matches:
            constants[name] = int(value)
        return constants

    def list_addresses(self) -> List[str]:
        return list(self.constants.keys())

    def get_address(self, name: str) -> int:
        return self.constants.get(name, None)

    def list(self):
        for address in self.list_addresses():
            print(f"{address}: {self.get_address(address)}")

# # Example usage:
# if __name__ == "__main__":
#     vhdl_parser = VHDLParser('./tubepsu_addresses_pkg.vhd')
#     print("All addresses:")
#     for address in vhdl_parser.list_addresses():
#         print(f"{address}: {vhdl_parser.get_address(address)}")

