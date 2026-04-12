# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the core functionality to confirm there are no runtime exceptions that were not present as build errors.

### 5. Execute Existing Tests

If the solution contains any test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures, as they may point to behavioral differences introduced by the migration to cross-platform .NET.

### 6. Check for Windows-Specific API Usage

Since this was a legacy project migration, scan the codebase for any remaining usage of Windows-specific APIs that may compile successfully but fail at runtime on non-Windows platforms. Common areas to check include:

- `Microsoft.Win32` namespace usage
- `System.Windows.Forms` or `System.Drawing` references
- Registry access
- Windows file path assumptions (e.g., backslash separators)

Use the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) to assist with this if needed.

### 7. Review Static Files and Configuration

For a web project such as `GadgetsOnline`, verify the following:

- `appsettings.json` is present and contains the correct configuration values previously held in `Web.config` or `App.config`.
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder.
- Any connection strings have been correctly migrated to `appsettings.json`.

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all expected files are present before deploying to the target environment.