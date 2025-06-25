import re
import os

def process_map_file(input_path, output_path):
    with open(input_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    # Step 1: Modify lines with format "$0061 = DisableLCD" → "DEF DisableLCD = $0061"
    modified_lines = []
    for line in lines:
        line = line.strip().replace(".", "")  # Remove all dots
        if line.startswith("$"):
            parts = line.split(" = ")
            if len(parts) == 2:
                address, name = parts
                new_line = f"DEF {name} = {address}\n"
                modified_lines.append(new_line)
                continue
        modified_lines.append(line + "\n")

    # Step 2: Remove lines containing a full stop (".")
    modified_lines = [line for line in modified_lines if "." not in line]  # Will be redundant now

    # Step 3: Keep only lines with a double-byte address ($XXXX)
    modified_lines = [line for line in modified_lines if re.search(r"\$[0-9A-Fa-f]{4}", line)]

    # Step 4: Remove lines containing "SECTION", "null", "empty"
    modified_lines = [line for line in modified_lines if not any(x in line for x in ["SECTION", "null", "empty"])]

    # Step 5: Remove lines starting with "TOTAL EMPTY" or "EMPTY"
    modified_lines = [line for line in modified_lines if not re.match(r"^(TOTAL EMPTY|EMPTY)", line)]

    with open(output_path, "w", encoding="utf-8") as f:
        f.writelines(modified_lines)

    print(f"Map processing complete. Cleaned file saved as: {output_path}")

def process_sym_file(input_path, output_path):
    with open(input_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    processed_lines = []
    for line in lines:
        match = re.match(r"^([0-9A-Fa-f]{2}):([0-9A-Fa-f]{4})\s+([\w.$@]+)", line.strip())
        if match:
            bank, address, label = match.groups()
            label = label.replace(".", "")  # Remove all dots from label
            address_int = int(address, 16)
            bank_line = f"DEF {label}_Bank = ${bank}\n"
            addr_line = f"DEF {label} = ${address}\n"
            if 0x4000 <= address_int < 0x8000:
                processed_lines.append(bank_line)
            processed_lines.append(addr_line)

    with open(output_path, "w", encoding="utf-8") as f:
        f.writelines(processed_lines)

    print(f"SYM processing complete. Converted file saved as: {output_path}")

def auto_process_files():
    for file in os.listdir():
        if file.endswith(".map"):
            output_path = os.path.splitext(file)[0] + ".inc"
            process_map_file(file, output_path)
        elif file.endswith(".sym"):
            output_path = os.path.splitext(file)[0] + ".inc"
            process_sym_file(file, output_path)

if __name__ == "__main__":
    auto_process_files()
