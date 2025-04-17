const fs = require('fs');
const path = require('path');

const filePath = process.argv[2];

if (!filePath) {
  console.error('Usage: node update-header.js <filePath>');
  process.exit(1);
}

if (!fs.existsSync(filePath)) {
  console.error(`File not found: ${filePath}`);
  process.exit(1);
}

const fileContent = fs.readFileSync(filePath, 'utf-8');

const h1HeaderRegex = /^# (.+)$/m;

const fileName = path.basename(filePath, '.md');

if (h1HeaderRegex.test(fileContent)) {
  const updatedContent = fileContent.replace(h1HeaderRegex, `# ${fileName}`);
  fs.writeFileSync(filePath, updatedContent, 'utf-8');
  console.log(`Updated header in ${filePath} to: # ${fileName}`);
} else {
  const updatedContent = `# ${fileName}\n` + fileContent;
  fs.writeFileSync(filePath, updatedContent, 'utf-8');
  console.log(`Added header to ${filePath}: # ${fileName}`);
}
