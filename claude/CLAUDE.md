- Always use `python3` not `python` when invoking the python binary
- Avoid hardcoding secrets in code
- use python3 instead of python locally
- use pnpm
- never use npm

# consensus-documentation-rule
CRITICAL: Every time you use the consensus tool (mcp__zen__consensus) to gather multi-model opinions, you MUST document the findings in /Users/dealair/src/fleetops-infra/docs/consensus-findings/ following this format:
1. Create a new file named: YYYY-MM-DD-topic-description.md
2. Include all models consulted, key agreements, disagreements, standards referenced, and implementation recommendations
3. Update the README.md index with the new entry
This ensures all consensus findings are preserved for future reference and team knowledge sharing.