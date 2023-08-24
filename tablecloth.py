#!/bin/env python3

import argparse
import textwrap

try:
    import requests
except ImportError:
    print("The 'requests' library is required but not installed.")
    print("Please install it by running the following command:")
    print("pip install requests")
    exit()

def get_cve_details(cve_id):
    url = f"https://services.nvd.nist.gov/rest/json/cve/1.0/{cve_id}"
    response = requests.get(url)
    return response.json()

def construct_vuln_table(cve_details):
    cve_data = cve_details['result']['CVE_Items'][0]
    cve_id = cve_data['cve']['CVE_data_meta']['ID']
    description = cve_data['cve']['description']['description_data'][0]['value']

    # Check for CVSSv3 scores
    cvssv3_data = cve_data['impact'].get('baseMetricV3', {}).get('cvssV3', {})
    cvssv3_score = cvssv3_data.get('baseScore', 'N/A')
    base_severity_v3 = cvssv3_data.get('baseSeverity', 'N/A')

    # Check for CVSSv2 scores
    cvssv2_data = cve_data['impact'].get('baseMetricV2', {})
    cvssv2_score = cvssv2_data.get('cvssV2', {}).get('baseScore', 'N/A')
    base_severity_v2 = cvssv2_data.get('severity', 'N/A')

    # Determine risk factor based on CVSSv3 or CVSSv2
    base_severity = base_severity_v3 if base_severity_v3 != 'N/A' else base_severity_v2

    # Extract references and surround URLs with quotes
    references = cve_data['cve']['references']['reference_data']
    reference_links = ',\n            '.join([f"\"{ref['url']}\"" for ref in references])

    vuln_table = f"""
local vuln_table = {{
    title = '{cve_id}', -- Default is CVE ID, but should be changed to a meaningful title
    state = vulns.STATE.NOT_VULN, -- Default to NOT_VULN
    IDS = {{CVE = '{cve_id}'}},
    risk_factor = '{base_severity}',
    description = [[
        {textwrap.fill(description, width=70)} 
]],
    references = {{ {reference_links} }},
    scores = {{
        CVSSv3 = '{cvssv3_score}',
        CVSSv2 = '{cvssv2_score}'
    }}
}}
    """
    return vuln_table

def main():
    # Accept CVE as an argument using argparse
    # Construct the vuln_table using the CVE details
    args = argparse.ArgumentParser()
    args.add_argument("cve_id", help="CVE ID to be checked")
    args = args.parse_args()

    cve_details = get_cve_details(args.cve_id)
    vuln_table = construct_vuln_table(cve_details)

    print(vuln_table)

if __name__ == "__main__":
    main()
