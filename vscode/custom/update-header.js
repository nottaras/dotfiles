const fs = require("fs");
const path = require("path");

const filePath = process.argv[2];

if (!filePath) {
  console.error("Usage: node update-header.js <filePath>");
  process.exit(1);
}

if (!fs.existsSync(filePath)) {
  console.error(`File not found: ${filePath}`);
  process.exit(1);
}

const fileContent = fs.readFileSync(filePath, "utf-8");

const h1HeaderRegex = /^# (.+)$/m;

const fileName = path.basename(filePath, ".md");
const fileNameProper = fileName.charAt(0).toUpperCase() + fileName.slice(1);

if (h1HeaderRegex.test(fileContent)) {
  const updatedContent = fileContent.replace(
    h1HeaderRegex,
    `# ${fileNameProper}`
  );
  fs.writeFileSync(filePath, updatedContent, "utf-8");
  console.log(`Updated header in ${filePath} to: # ${fileNameProper}`);
} else {
  const updatedContent = `# ${fileNameProper}\n` + fileContent;
  fs.writeFileSync(filePath, updatedContent, "utf-8");
  console.log(`Added header to ${filePath}: # ${fileNameProper}`);
}
