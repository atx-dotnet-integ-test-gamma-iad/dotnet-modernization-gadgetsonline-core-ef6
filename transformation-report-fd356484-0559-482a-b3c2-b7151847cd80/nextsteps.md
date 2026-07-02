# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing or incompatible packages.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`). Ensure this aligns with your deployment environment.

### 4. Run the Application Locally
Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key user-facing features.

### 5. Run Existing Tests
If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during the transformation or pre-existing issues.

### 6. Check Runtime Behavior for Platform-Specific Code
Even without build errors, certain areas warrant manual review:

- **File paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) remain in configuration files or code.
- **Registry access**: Any use of `Microsoft.Win32.Registry` will not function on Linux/macOS.
- **Windows Authentication**: If used, verify it is supported in the target hosting environment.
- **`System.Drawing`**: If used for image processing, consider replacing it with a cross-platform alternative such as `SkiaSharp` or `ImageSharp`.

### 7. Review Configuration Files
Check `appsettings.json` (and environment-specific variants) to ensure connection strings and other settings are correctly configured for the new runtime and target environment.

### 8. Verify Static Assets and Views
If this is a web project, manually browse through the application UI to confirm that static files, Razor views, or other front-end assets are being served correctly under the new project structure.

## Deployment

### 1. Publish the Application
Generate a publish output using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present.

### 2. Validate the Published Output
Run the published output directly to confirm it behaves identically to the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

### 3. Update the Hosting Environment
Ensure the server or hosting environment has the correct .NET runtime version installed. You can verify the available runtimes with:

```bash
dotnet --list-runtimes
```

Install the required runtime if it is not present before deploying the published output.